
# smetlite

<!-- badges: start -->
<!-- badges: end -->

The goal of smetlite is to ease working with SMET files from meteorology.
The specification of these files you find in
https://models.slf.ch/docserver/meteoio/SMET_specifications.pdf.

A few short example smet files are included in the package;
real life examples you can for instance download from 
https://www.envidat.ch/dataset/38112bee-f865-4b29-ba19-47a99ba78833/resource/3074d1dc-6083-4025-9ac4-484cfa88658b/download/wfj_optimaldataset_v7.smet
or https://www.envidat.ch/dataset/a9264e9f-ea9b-4c89-b471-464efb891826/resource/a5918c50-6716-4dcf-b462-e1970ae1e072/download/wfj.smet.

Suggestions for useful extension of this tiny package are very welcome!

## Installation

You can install the development version of smetlite from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("baselr/smetlite")
```

## Example

Simple example how to read in a smet file:

``` r
library(smetlite)
read_smet(system.file('examples/test.smet', package = 'smetlite'))
```
