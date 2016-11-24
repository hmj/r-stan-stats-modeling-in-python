data {
  int N;
  int N_new;
  real X[N];
  real X_new[N_new];
  real Y[N];
}

parameters {
  real a;
  real b;
  real<lower=0> sigma;
}

model {
  for (n in 1:N) {
    Y[n] ~ cauchy(a + b*X[n], sigma);
  }
}

generated quantities {
  real y_new[N_new];
  for (n in 1:N_new)
    y_new[n] = cauchy_rng(a + b*X_new[n], sigma);
}
