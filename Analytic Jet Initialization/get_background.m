function bar = get_background(field)
bar = zeros(size(field,3), 1);
for nn=1:length(bar)
   bar(nn) = mean(mean(field(:,:,nn))); 
end
end
