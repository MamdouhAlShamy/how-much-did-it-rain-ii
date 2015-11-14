normal = c(0.03123333, 0.00075 , 0.007366667, 0.1255, 6.46045 )
parallel = c(0.00135 , 0.002533333 , 0.007366667 , 0.1396833 , 5.031533)
multi
n = c(10, 100, 1000, 10000, 100000)
plot(n, normal, type= "o", col= "blue")
lines(n, parallel, col="green", type="o")
