#' Simulated longitudinal ADAS-cog and MMSE scores
#'
#' A dataset containing longitudinal simulated ADAS-cog and MMSE scores
#' for a large number of individuals that are cognitively normal, have mild
#' congnitive impairment (MCI) or dementia.
#' Data is simulated based on ADNI data.
#'
#' @format A data frame with 9378 rows and 7 variables:
#' \describe{
#'   \item{subject_id}{Subject ID}
#'   \item{Month_bl}{Months since baseline}
#'   \item{ADAS13}{Simulated 13-item ADAS-cog score}
#'   \item{MMSE}{Simulated MMSE score}
#'   \item{CN}{Was subject cognitively normal at baseline (0/1)?}
#'   \item{MCI}{Was subject mild cognitively impaired at baseline (0/1)?}
#'   \item{DEM}{Did subject have dementia at baseline (0/1)?}
#'   \item{blstatus}{Patient status at baseline (Cognitively normal/MCI/Dementia)}
#' }
"adas_mmse_data"