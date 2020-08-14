# Disease progression modeling based on nonlinear mixed effects modeling
progmod is an R package for estimating population-level disease progression patterns based on aligning short-term longitudinal observed patterns. The models are formulated as nonlinear mixed effect models and estimation in these models is done using maximum likelihood estimation. 

The basic idea of the model is to use patterns in data to map observed time (e.g. time since baseline) to disease time (both on a group level and individual level). The animation below shows an example in Alzheimer's disease where the observation times of ADAS-cog total scores from the [ADNI study](http://adni.loni.usc.edu/) are mapped to predicted disease time of the five baseline groups (Cognitively normal, Significant memory concern, early and late MCI, dementia) and to individual disease time.


![](man/readme/adas_progression.gif)

The results shown in the animation are from the basic model presented in the paper 

<dl>
  <dd>
Raket, Lars Lau. "Statistical Disease Progression Modeling in Alzheimer Disease." *Frontiers in Big Data* (2020). [DOI: 10.3389/fdata.2020.00024](https://doi.org/10.3389/fdata.2020.00024)
  </dd>
</dl>

These model predictions for ADNI based on the 13-item ADAS-cog scores are available in [data/ADNI_disease_stage_bl.txt](data/ADNI_disease_stage_bl.txt). If you use this package or data, please cite the above paper.

## Multivariate disease progression models
progmod supports simultaneous modeling of progression on multiple outcomes as described in the paper

<dl>
  <dd>
Kühnel, Line, Anna-Karin Berger, Bo Markussen, and Lars Lau Raket. "Simultaneous Modelling of Alzheimer’s Disease Progression via Multiple Cognitive Scales." <em>in revision</em> (2020). 
  </dd>
</dl>

An example of multivariate modeling is available in the documentation.

## Installation

You can install `progmod` directly from github using devtools:

``` r
# install.packages('devtools')
devtools::install_github('larslau/progmod')
```

## Use and examples
The package contains simulated ADAS-cog and MMSE data for exploration of models. Examples of how to specify models for these data are available by running
``` r
library(progmod)
example(progmod)
```

