library(deSolve)
library(tidyr)
library(dplyr)

library(shellpipes)
loadEnvironments()

sijmod <- function(t, v, p){
	with(c(as.list(v), as.list(p)), {
		u <- 1 ## So that we can automatically swap 1s and 2s in the editor
		lam1 <- bet1*(I1 + (u-pt21)*J1)/N
		lam2 <- bet2*(I2 + (u-pt12)*J2)/N
		nonVital <- c(
			dS = - (lam1 + lam2)*S
			, dI1 = lam1*S - I1/D
			, dR1 = I1/D - lam2*(u-ps12)*R1 - lam2*ps12*B*R1
			, dI2 = lam2*S - I2/D
			, dR2 = I2/D - lam1*(u-ps21)*R2 - lam1*ps21*B*R2
			, dJ1 = lam1*(u-ps21)*R2 - J1/D
			, dJ2 = lam2*(u-ps12)*R1 - J2/D
			, dR = lam2*ps12*B*R1 + lam1*ps21*B*R2 + (J1+J2)/D 
			, dC1 = lam1*S  + lam1*(u-ps21)*R2 
			, dC2 = lam2*S  + lam2*(u-ps12)*R1 
		)
		## Vital dynamics: add vector (N-V)/L
		## V is the vector of state variables (excluding the cumulators)
		vital <- c(-v[1:8], 0, 0)
		vital[[1]] <- vital[[1]] + N
		return(list(nonVital+vital/L))
	})
}

init = c(S=999
	, I1=1, R1=0
	, I2=0, R2=0
	, J1=0, J2=0 , R=0
	, C1=0, C2=0
)
parms = c(D=5*day, L=5000*year, N=2000
	, bet1=0.8/day, bet2=0.9/day
	, D1 = 4*day, D2=5*day
	, ps12 = 0.5, ps21 = 0.6
	, pt12 = 0, pt21 = 0
	, B = 0
) 

pre <- as.data.frame(ode(func=sijmod
	, y = init
	, parms=parms
	, times = (0:80)*day
))

end <- pre[nrow(pre), -1]
end[["I2"]] <- 1
restart <- as.numeric(end)
names(restart) <- names(end)

post <- as.data.frame(ode(func=sijmod
	, y = restart
	, parms=parms
	, times = (80:160)*day
))

states <- bind_rows(pre, post)

summary(states)

inc <- (states
	|> reframe(width=diff(time)
		, i1 = diff(C1)
		, i2 = diff(C2)
		, mid = (time[-1] + time[-length(time)])/2
	)
)

summary(inc)

## Be careful about unit logic with width
longInc <- (inc
	|> transmute(time=mid
		, inc1=i1/width
		, inc2=i2/width
	)
	|> pivot_longer(cols=-time, values_to="incidence")
)

summary(longInc)
rdsSave(longInc)
