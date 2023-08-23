
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `{XlsFormUtil}`

<!-- badges: start -->
<!-- badges: end -->

The goal of {XlsFormUtil} is to bring additional capacities when
designing XlsForm questionnaires.

Currently this includes:

- Estimate questionnaire duration

- Output a pretty print version from a maste version in xlsform

- Perform a systematic comparison between an initial questionnaire
  (master) and a customized and contextualised version. This allow to
  ensure that all key variables required for indicator calculation are
  correctly included.

The packages is also available as a shinyApp @
<https://rstudio.unhcr.org/XlsFormUtil/>

## Installation

You can install the development version of XlsFormUtil from
[GitHub](https://github.com/unhcr-americas/XlsFormUtil) with:

``` r
# install.packages("devtools")
devtools::install_github("unhcr-americas/XlsFormUtil")
```

For developers, look fork the repository and look at the dev folder.

## Example

The packages comes with a companion ShinyApp

``` r
library("XlsFormUtil")
XlsFormUtil::run_app()
```

## Reference

The package mostly leverages the capacity of the
[{flextable}](https://ardata-fr.github.io/flextable-book/layout.html)
package and embed UNHCR template from
[{unhcrdown}](https://vidonne.github.io/unhcrdown/).

Two other R package / projects
[QuestionnaireHTML](https://github.com/hedibmustapha/QuestionnaireHTML)
and [ODK2Doc](https://github.com/zaeendesouza/ODK2Doc) were built with
the same goal but with a limited scope and styling capacity. Last
there’s also from a similar project in python:
<https://github.com/pmaengineering/ppp>
