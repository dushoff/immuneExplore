library(ggplot2); theme_set(theme_bw())

library(shellpipes)
loadEnvironments()

inc <- rdsRead()

print(ggplot(inc)
	+ aes(time/day, incidence, color=name)
	+ geom_line()
	+ xlab("Time (days)")
)

