n = 100000;
successes = 0;

for i=1:n
    visited_squares = [1];
    square = 1;
    while square < 120
        d1 = randi([1 6],1,1);
        d2 = randi([1 6],1,1);
        roll = d1 + d2;
        square = square + roll;
        visited_squares = [visited_squares square];
    end
    
    for j = 1:length(visited_squares)
       if visited_squares(j) == 120
           successes = successes + 1;
       end
    end
end

disp(successes/n)