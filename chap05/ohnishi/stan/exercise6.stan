data {
  int N;
  real X[N];
  int<lower=0> Y[N];
  int<lower=0, upper=1> f[N];
}

parameters {
  real b[3];
}

model {
  for (n in 1:N)
    Y[n] ~ poisson_log(b[1] + b[2]*X[n] + b[3]*f[n]);
}

generated quantities {
  real y_pred[N];
  for (n in 1:N)
    y_pred[n] <- poisson_log_rng(b[1] + b[2]*X[n] + b[3]*f[n]);
}