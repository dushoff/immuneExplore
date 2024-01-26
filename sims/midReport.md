
## Immunity Modelling for Respiratory Diseases Interim report

### 2024 Jan 26 (Fri)

We have built a two-strain model that incorporates partial cross-protection against infection, partial cross-protection against transmission, and immune boosting. The current simple model does not explicit incorporate polarization: instead we rely on earlier work that shows that we can tune from leaky dynamics to polarized dynamics using our immune-boosting parameter.

![Conceptual diagram](/home/dushoff/Downloads/midDiagram.png){#fig:diagram}

The model will allow us to compare and contrast the effects of different _models_ of immunity (leaky vs. polarized), and different _effects_ of immunity (currently, reduction in susceptibility vs. reduction in transmission, severity will be added downstream, since it is less integral to dynamics).

![Sample model output. A second strain has been introduced while a first strain is declining. The initial dynamics of the second strain do not depend on boosting, but the longer-term effects so.](sij.incPlot.Rout.pdf){#fig:ts}

Code is under development and has been shared on a repository.

