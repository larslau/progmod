#' Overparametrized exponential function.
#'
#' @param t Time variable
#' @param l Scale parameter for the exponential function
#' @param s Time-shift parameter
#' @param g Time-scaling parameter
#' @param v Intercept parameter
#' @return The function values at the supplied time values along with a
#'         "gradient" attribute.
#' @examples
#' exp_model(t = c(0, 1), l = 1, s = 0, g = 0, v = 0)
#' @export

exp_model <- deriv(
  expression(l * exp((t + s) / exp(g)) + v),
  namevec = c('l', 's', 'g', 'v'),
  function.arg = c('t', 'l', 's', 'g', 'v'))

#' Overparametrized generalized logistic function.
#'
#' @param t Time variable
#' @param A Lower asymptote parameter
#' @param K Upper asymptote parameter
#' @param B Time-scaling parameter
#' @param s Time-shift parameter
#' @param v Asymmetry parameter
#' @param c Intercept parameter, should only be used for random effects
#' @return The function values at the supplied time values along with a
#'         "gradient" attribute.
#' @examples
#' GLF(t = c(0, 1), A = 30, K = 0, B = 1, s = 0, v = 1, c = 0)
#' @export

GLF <- deriv(
  expression(A + (K - A) / ((1 + exp(-B * (t + s)))^(v)) + c),
  namevec = c('A', 'K', 'B', 'v', 's', 'c'),
  function.arg = c('t', 'A', 'K', 'B', 'v', 's', 'c'))



#' Fit nonlinear mixed-effects disease progression models
#'
#' This function is a wrapper for \code{\link[nlmeBM]{nlmeBM}}.
#' @param model A nonlinear model formula, with the response on the left of a ~
#' operator and an expression involving parameters and covariates on the right,
#' or an nlsList object. If data is given, all names used in the formula should
#' be defined as parameters or variables in the data frame. The method function
#' nlme.nlsList is documented separately. See \code{\link[nlme]{nlme}} for details.
#' @param data An optional data frame containing the variables named in model,
#' fixed, random, correlation, weights, subset, and naPattern.
#' By default the variables are taken from the environment.
#' @param fixed A two-sided linear formula of the form \code{f1+...+fn~x1+...+xm},
#' or a list of two-sided formulas of the form \code{f1~x1+...+xm}, with possibly
#' different models for different parameters. The \code{f1,...,fn} are the names of
#' parameters included on the right hand side of model and the \code{x1+...+xm}
#' expressions define linear models for these parameters (when the left hand
#' side of the formula contains several parameters, they all are assumed to
#' follow the same linear model, described by the right hand side expression).
#' A \code{1} on the right hand side of the formula(s) indicates a single fixed effects
#' for the corresponding parameter(s).
#' @param random A two-sided formula of the form
#' \code{r1+...+rn~x1+...+xm | g1/.../gQ}, with \code{r1,...,rn} naming parameters included on the
#' right hand side of model, \code{x1+...+xm} specifying the random-effects model for these
#' parameters and \code{g1/.../gQ} the grouping structure (\code{Q} may be equal to \code{1}, in which
#' case no / is required). The random effects formula will be repeated for all
#' levels of grouping, in the case of multiple levels of grouping. Explicit specification of the
#' covariance structure between random effects (e.g. using \code{pdMat}) is not possible with this
#' wrapper, but can be achieved by directly specifying the model using \code{\link[nlme]{nlme}}.
#' @param start A numeric vector or list of initial estimates for the fixed effects and random effects.
#' If declared as a numeric vector, it is converted internally to a list with a single component fixed, given by the vector.
#' The \code{fixed} component is required, unless the model function inherits from
#' class \code{selfStart}, in which case initial values will be derived
#' from a call to \code{nlsList}. An optional \code{random} component is used to specify
#' initial values for the random effects and should consist of a matrix,
#' or a list of matrices with length equal to the number of grouping levels.
#' Each matrix should have as many rows as the number of groups at the
#' corresponding level and as many columns as the number of random effects in that level.
#' @param covariance An optional \code{\link[nlme]{corStruct}} object describing the within-group
#' covariance structure. In addition to those available in \code{nlme},
#' \code{\link{covBM}} can be used to incorporate a Brownian motion component, \code{\link{covFracBM}}
#' can be used to incorporate a fractional Brownian motion component and \code{\link{covIOU}}
#' can be used to incorporate an integrated Ornstein-Uhlenbeck process in relation to
#' a continuous variable.
#' @param method a character string. If "\code{REML}" the model is fit by maximizing the restricted log-likelihood.
#' If "\code{ML}" the log-likelihood is maximized. Defaults to "\code{ML}".
#' @param control A list of control parameters for the estimation algorithm. See \code{\link[nlmeControl]{nlmeControl}}.
#' @param verbose If \code{TRUE} information on the evolution of the iterative
#' algorithm is printed. Default is \code{FALSE}.
#' @return An object of class "nlme" representing the nonlinear mixed effects model fit.
#' @examples
#'
#'#
#'# Fit exponential disease progression model to simulated ADAS-cog scores
#'#
#'
#'# Plot data
#'if (require(ggplot2)) {
#'ggplot(adas_mmse_data, aes(x = Month_bl, y = ADAS13)) +
#'  geom_line(aes(group = subject_id, color = blstatus)) +
#'  ylim(c(85, 0)) +
#'  xlab('Months since baseline')
#'}
#'
#'# Fit exponential model with random shift and intercept
#'fixed_start_coef <- c(0.5, 70, 150, 3.5, 10)
#'ADAS_progmod <- progmod(ADAS13 ~ exp_model(Month_bl, l, s, g, v),
#'                        data = subset(adas_mmse_data, !is.na(ADAS13)),
#'                        fixed = list(l ~ 1,
#'                                     s ~ MCI + DEM - 1,
#'                                     g ~ 1,
#'                                     v ~ 1),
#'                        random = s + v ~ 1 | subject_id,
#'                        start = fixed_start_coef,
#'                        covariance = NULL)
#'
#'# Predict from model and visualize results
#'adas_mmse_data$fixed_shift_adas <- with(adas_mmse_data,
#'                                        MCI * fixed.effects(ADAS_progmod)[2] +
#'                                          DEM * fixed.effects(ADAS_progmod)[3])
#'pred_rand <- random.effects(ADAS_progmod)
#'adas_mmse_data$random_shift_adas <- pred_rand[match(adas_mmse_data$subject_id, rownames(pred_rand)), 's.(Intercept)']
#'
#'if (require(ggplot2)) {
#'  ggplot(adas_mmse_data, aes(x = Month_bl + fixed_shift_adas, y = ADAS13)) +
#'    geom_line(aes(group = subject_id, color = blstatus)) +
#'    ylim(c(85, 0)) +
#'    xlab('Months since baseline')
#'}
#'
#'
#'if (require(ggplot2)) {
#'  ggplot(adas_mmse_data, aes(x = Month_bl + fixed_shift_adas + random_shift_adas, y = ADAS13)) +
#'    geom_line(aes(group = subject_id, color = blstatus)) +
#'    ylim(c(85, 0)) +
#'    xlab('Months since baseline')
#'}
#'
#'#
#'# Fit generalized logistic disease progression model to simulated MMSE scores
#'#
#'
#' # Plot data
#'
#'if (require(ggplot2)) {
#'  ggplot(adas_mmse_data, aes(x = Month_bl, y = MMSE)) +
#'    geom_line(aes(group = subject_id, color = blstatus)) +
#'    ylim(c(0, 30)) +
#'    xlab('Months since baseline')
#'}
#'
#'# Fit generalized logistic model with range [30, 0] and a random time shift
#'fixed_start_coef <- c(B = 0.025,
#'                      v = 1.4,
#'                      `s.(Intercept)` = -100,
#'                      s.MCI = 26,
#'                      s.DEM = 75)
#'
#'MMSE_progmod_glf <- progmod(MMSE ~ GLF(Month_bl, A = 30, K = 0, B, v, s, c = 0),
#'                            data = subset(adas_mmse_data, !is.na(MMSE)),
#'                            fixed = list(B ~ 1,
#'                                         v ~ 1,
#'                                         s ~ MCI + DEM + 1),
#'                            random = s ~ 1 | subject_id,
#'                            start = fixed_start_coef,
#'                            covariance = NULL)
#'
#'# Predict from model and visualize results
#'adas_mmse_data$fixed_shift_mmse <- with(adas_mmse_data,
#'                                        MCI * fixed.effects(MMSE_progmod)[2] +
#'                                          DEM * fixed.effects(MMSE_progmod)[3])
#'pred_rand <- random.effects(MMSE_progmod)
#'adas_mmse_data$random_shift_mmse <- pred_rand[match(adas_mmse_data$subject_id, rownames(pred_rand)), 's.(Intercept)']
#'
#'
#'
#'if (require(ggplot2)) {
#'  ggplot(adas_mmse_data, aes(x = Month_bl + fixed_shift_mmse + random_shift_mmse, y = MMSE)) +
#'    geom_line(aes(group = subject_id, color = blstatus)) +
#'    xlab('Months since baseline')
#'}
#' @export
#' @import nlme covBM

progmod <- function(model, data, fixed, random, start, covariance = NULL,
                    method = c("ML", "REML"), control = NULL, verbose = FALSE) {

  # Set control parameters if not given
  if (is.null(control)) {
    control <- nlmeControl(maxIter = 50, # Can be increased
                           pnlsMaxIter = 7, # Should not be increased too much beyond 7
                           msMaxIter = 500, # 50-500
                           minScale = 0.01,
                           tolerance = 1e-5,
                           niterEM = 25, # 25-100
                           pnlsTol = 0.001,
                           msTol = 1e-6,
                           msVerbose = FALSE,
                           apVar = TRUE,
                           .relStep = 1-06,
                           minAbsParApVar = 0.05,
                           natural = TRUE)
  }

  if (is.null(covariance)) {
    nlme(model = model,
         data = data,
         fixed = fixed,
         random = random,
         start = start,
         method = method,
         control = control,
         verbose = verbose)
  } else {
    nlmeBM(model = model,
           data = data,
           fixed = fixed,
           random = random,
           start = start,
           covariance = covariance,
           method = method,
           control = control,
           verbose = verbose)
  }
}

