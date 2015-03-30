clear all ;

global seed ;

seed = 0.12345 ;
randomize();
a = zeros(1,5000);
b = zeros(1,5000);

for i = 1:5000   
    a(i) = randomperc();
end

rng(seed, 'twister');
for i = 1:5000    
    b(i) = rand(1);
end