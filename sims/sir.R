library(deSolve)

library(shellpipes)
loadEnvironments()

sirmod <- function(t, v, p){
	with(c(as.list(v), as.list(p)), {
		trans <- bet*S*I/N
		return(list(c(
			dS=(N-S)/L - trans
			, dI= trans - I/L - I/D
			, dC = trans
		)))
	})
}

sim <- as.data.frame(ode(func=sirmod
	, y = c(S=999, I=1, C=0)
	, parms = c(bet=0.8/day, D=5*day, L=50*year, N=2000)
	, times = (0:100)*day
))

print(sim)
