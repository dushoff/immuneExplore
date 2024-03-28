library(ggplot2); theme_set(theme_bw())
library(dplyr)

library(shellpipes)
startGraphics(height=4.5)
loadEnvironments()

l <- rdsReadList()
names(l)

eps <- 0.5

no <- l[[1]] |> filter(incidence>eps)
boost <- l[[2]] |> filter(incidence>eps)

print(ggplot(no)
	+ aes(time/day, incidence, color=name)
	+ geom_line()
	+ geom_line(data=boost, lty=2)
	+ xlab("Time (days)")
	+ ylim(c(0, 10))
	+ theme(legend.position="none")
)

