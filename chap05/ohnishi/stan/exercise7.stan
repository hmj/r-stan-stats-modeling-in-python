data {
  int I;
  int N[I];
  real X[I];
  int<lower=0> Y[I];
  int<lower=0, upper=1> f[I];
}

parameters {
  real b[3];
}

transformed parameters {
  real q[I];
  for (i in 1:I) { 
    q[i] <- inv_logit(b[1] + b[2]*X[i] + b[3]*f[i]);
  }
}

model {
  for (i in 1:I)
    Y[i] ~ binomial(N[i], q[i]);
}

generated quantities {
  real y_pred[I];
  for (i in 1:I)
    y_pred[i] <- binomial_rng(N[i], q[i]);
}