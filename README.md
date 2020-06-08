# Disease progression modeling based on nonlinear mixed effects modeling
progmod is an R package for estimating population-level disease progression patterns based on aligning short-term longitudinal observed patterns. The models are formulated as nonlinear mixed effect models and estimation in these models is done using maximum likelihood estimation.

The appliactions and examples of this methodology has primarily been within Alzheimer's disease and dementia, but other applications are possible.

If you use this package, please cite

Raket, Lars Lau. "Disease progression modeling in Alzheimer's disease: insights from the shape of cognitive decline." *medRxiv* (2019). doi: [https://doi.org/10.1101/2019.12.13.19014860]

## Installation

You can install progmod from github using devtools:

``` r
# install.packages('devtools')
devtools::install_github('larslau/progmod')
```

## Use and examples
The model can be used to estimate a disease timeline by aligning short-term longitudinal observations to disease. The model is described in the following tweet: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I have written a paper (<a href="https://t.co/KWtNXky1A4">https://t.co/KWtNXky1A4</a>) about modeling of disease progression in Alzheimer&#39;s disease. The proposed model (illustrated in the video) aligns patients along a continuous disease spectrum. <a href="https://twitter.com/hashtag/Alzheimers?src=hash&amp;ref_src=twsrc%5Etfw">#Alzheimers</a> <a href="https://twitter.com/hashtag/Alzheimer?src=hash&amp;ref_src=twsrc%5Etfw">#Alzheimer</a> <a href="https://twitter.com/hashtag/alzheimerdisease?src=hash&amp;ref_src=twsrc%5Etfw">#alzheimerdisease</a> <a href="https://twitter.com/hashtag/dementia?src=hash&amp;ref_src=twsrc%5Etfw">#dementia</a> <a href="https://t.co/2apFUqRKAx">pic.twitter.com/2apFUqRKAx</a></p>&mdash; Lars Lau Raket (@LarsRaket) <a href="https://twitter.com/LarsRaket/status/1206864427368226817?ref_src=twsrc%5Etfw">December 17, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

The package contains simulated ADAS-cog and MMSE data. Examples of how to specify models for these data are available by running
``` r
demo(progmod)
```
