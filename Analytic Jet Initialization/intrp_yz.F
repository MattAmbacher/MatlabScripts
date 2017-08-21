c     This program reads the output from the SOR calculation 
c     of the initial state (nobouss), then interpolates in order to 
c     have u, theta and rho on a cartesian grid to initialize
c     WRF
c     Riwal Plougonven, 2005
c     NB does not interpolate in y at this point
      PROGRAM INTRP_YZ
      IMPLICIT NONE
      REAL, PARAMETER :: G=9.8,FF=1.E-4
      REAL, PARAMETER :: LZ=20.E3,LY=LLYY
      INTEGER, PARAMETER :: NY=NNYY
      INTEGER, PARAMETER :: NPI=NNPPII,NZ=NNZZ
      REAL, PARAMETER :: PBOT=PPBBOOTTe05,PITOP=426.,CP=1004.
     1     ,CV=717.,KAPPA=(CP-CV)/CP
      REAL, PARAMETER :: ZSAFE=ZZSSAFE
c      REAL, PARAMETER :: PBOT=1.E5,PTOP=0.25E4,CP=1004.
c     1     ,CV=717.,KAPPA=(CP-CV)/CP
cccccccccccccccccccccccc
      REAL, DIMENSION(NPI,NY) :: PHI,Z,UI,THI
      REAL, DIMENSION(NPI) :: PILVLS,PRI
      REAL, DIMENSION(NZ) :: ZL
      REAL, DIMENSION(NZ,NY) :: RHO,UO,THO,PO,q,P
      REAL :: DPI,PIBOT,DZ,DZL,DY,ZMIN
      REAL :: ZSURFMIN,ZSURFMAX
      INTEGER :: K,J,KUP,KDN,KI,KO

      open(unit=10,file='phi.d',status='old')
      open(unit=11,file='uthr.d',status='unknown')

      pibot=cp
      dpi=(pibot-pitop)/float(npi-1)
      dy=ly/float(ny-1)
      dzl=lz/float(nz-1)
cccccc READING 
      do j=1,ny
         do k=1,npi
            read(10,*) phi(k,j),ui(k,j),thi(k,j)
         enddo
      enddo
      z=phi/g
      zmin=50000.      
      zsurfmin = 50000.
      zsurfmax = -50000.
      do j=1,ny
         zmin=min(zmin,z(npi,j))
         zsurfmin=min(zsurfmin,z(1,j))
         zsurfmax=max(zsurfmax,z(1,j))
      enddo
      write(6,*) 'Altitude minimum',zmin
      write(6,*) 'Altitude surf min',zsurfmin
      write(6,*) 'Altitude surf max',zsurfmax
c      Rmod 12 May 2005: to get rid of bizarre surface stuff
c      z = z-zsurfmax
      z = z-zsurfmax-zsafe
c      Rend 12 May 2005
      do k=1,npi
         pilvls(k)=pibot-float(k-1)*dpi
         pri(k)=pbot*(pilvls(k)/cp)**(1/kappa)
      enddo

cccccc OUTPUT LEVELS
      do k=1,nz
         zl(k)=float(k-1)*dzl
      enddo

cccccc INTERPOLATING
      do j=1,ny
       ki=1  
       do ko=1,nz
         do 
          if ((zl(ko).ge.z(ki,j)).and.(zl(ko).le.z(ki+1,j))) 
     1     then
             dz=z(ki+1,j)-z(ki,j)
             uo(ko,j)=(zl(ko)-z(ki,j))/dz*ui(ki+1,j)+
     1            (z(ki+1,j)-zl(ko))/dz*ui(ki,j)
             tho(ko,j)=(zl(ko)-z(ki,j))/dz*thi(ki+1,j)+
     1            (z(ki+1,j)-zl(ko))/dz*thi(ki,j)
             po(ko,j)=(zl(ko)-z(ki,j))/dz*pri(ki+1)+
     1            (z(ki+1,j)-zl(ko))/dz*pri(ki)      
           exit
           else 
            ki=ki+1
            if (ki.gt.npi) then
              write(6,*) 'Lz higher than Lpi... j=',j,', zl=',zl(ko)
              exit
            endif
          endif
         enddo
       enddo
      enddo


ccccc WRITING OUT RESULTS
      call rhofromp(po,nz,ny,dzl,g,rho)
      call pvcal(uo,tho,rho,nz,ny,dzl,dy,ff,q)
      do j=1,ny
         do k=1,nz
            write(11,*) uo(k,j),tho(k,j),rho(k,j),q(k,j)
         enddo
      enddo 
     
  
      STOP 
      END

cccccccccccccccccccccccccccccccccccccccccccccccccccccccc
      subroutine rhofromp(p,nz,ny,dz,g,rho)
      implicit none
      integer, intent(in) :: nz,ny
      real, intent(in) :: dz,g
      real, intent(in), dimension(nz,ny) :: p
      real, intent(out), dimension(nz,ny) :: rho
      integer :: k,j
      
      do k=2,nz-1
         do j=1,ny
          rho(k,j)=-(p(k+1,j)-p(k-1,j))/(2*g*dz)  
         enddo
      enddo

      rho(1,:)=rho(2,:)-(rho(3,:)-rho(2,:))
      rho(nz,:)=rho(nz-1,:)+(rho(nz-1,:)-rho(nz-2,:))

      return
      end
      
cccccccccccccccccccccccccccccccccc
      subroutine pvcal(u,th,rho,nz,ny,dz,dy,ff,q)
      implicit none
      integer,intent(in) :: nz,ny
      real, intent(in) :: dy,dz,ff
      real, intent(in), dimension(nz,ny) :: u,th,rho
      real, intent(out), dimension(nz,ny) :: q
      real :: a1,a2,a3
      integer :: k,j

      do k=2,nz-1
       do j=1,ny-1
          a1=ff-(u(k,j+1)-u(k,j-1))/(2.*dy)
          a2=(th(k+1,j)-th(k-1,j))/(2.*dz)
          a3=(u(k+1,j)-u(k-1,j))/(2.*dz)*
     1       (th(k,j+1)-th(k,j-1))/(2.*dy)
          q(k,j)=(a1*a2+a3)/rho(k,j)
       enddo
      enddo
      q(:,1)=q(:,2)
      q(:,ny)=q(:,ny-1)
      q(1,:)=q(2,:)
      q(nz,:)=q(nz-1,:)      

      return 
      end

cccccccccccccccccccccccccccccccccc
      function ran1(idum)
c     taken from Numerical Recipes in Fortran, p 271
      implicit none
      integer, parameter :: ia=16807, im=2147483647
      integer, parameter :: iq=127773
      integer, parameter :: ir=2836, ntab=32
      integer, parameter :: ndiv=1+(im-1)/ntab
      real, parameter :: eps=1.2e-7, am=1./im
      real, parameter :: rnmx=1.-eps
      integer :: iy=0
      integer, dimension(ntab) :: iv = 0
      integer :: j, k, idum
      real :: ran1
      save iv,iy

      if (idum.le.0.or.iy.eq.0) then
         idum=max(-idum,1)
         do j=ntab+8,1,-1
            k=idum/iq
            idum=ia*(idum-k*iq)-ir*k
            if (idum.lt.0) idum=idum+im
            if (j.le.ntab) iv(j)=idum
         enddo
         iy=iv(1)
      endif
      k=idum/iq
      idum=ia*(idum-k*iq)-ir*k
      if (idum.lt.0) idum=idum+im
      j=1+iy/ndiv
      iy=iv(j)
      iv(j)=idum
      ran1=min(am*iy,rnmx)
      ran1=ran1-0.5
      return
      end


