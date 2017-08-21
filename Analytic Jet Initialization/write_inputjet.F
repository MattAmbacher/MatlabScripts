!     This program takes the output of interpl
!     and writes it out in a file with the right
!     format for read_input_jet to read it
!     Riwal Plougonven, 2005
      PROGRAM WRITE_INPUTJET
      IMPLICIT NONE
!INTEGER, parameter :: nz=NNZZ, ny=NNYY
      INTEGER, parameter :: nz=51, ny=60
!REAL, dimension(nz,ny) :: U,T,R,Q
      REAL, dimension(1:ny*nz) :: u,t,r
      REAL, dimension(1:ny,1:nz) :: field_in,field_out
      INTEGER :: j,k,iloop 

!OPEN(unit=10, file='uthr.d', status='old')
      OPEN(unit=10, file='u.txt', status='old', convert='big_endian')
!      OPEN(unit=10, file='uthrav.d', status='old')
      OPEN(unit=11, file='new_input_jet', 
     &     form= 'unformatted', status='unknown', convert='big_endian')
      OPEN(unit=12, file='T.txt', status='old', convert='big_endian')
      OPEN(unit=13, file='rho.txt', status='old', convert='big_endian')
!-----------------------------------------------------
      do j=1,nz*ny
         !do k=1,nz
!read(10,*) u(k,j),t(k,j),r(k,j)
            read(10,*, end=100) u(j)
         !enddo
      enddo 
 100  close(10)

      do j=1,ny*nz
         read(12,*,end=101) t(j)
      enddo
 101  close(12)

      do j=1,ny*nz
         read(13,*,end=102) r(j)
      enddo
 102  close(13)
         
!-----------------------------------------------------
      rewind(11) 
      write(11) ny,nz
      field_out= reshape(u, (/ ny, nz /) )
      write(11) field_out
      field_out = reshape(t, (/ ny, nz /) )
      write(11) field_out
      field_out = reshape( r, (/ ny, nz /) )
      write(11) field_out
      stop 
      end

