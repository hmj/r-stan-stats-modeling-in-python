data {
  int N;
  real Area[N];
  real Y[N];
  int N_new;
  real Area_new[N_new];
}

parameters {
  real b1;
  real b2;
  real<lower=0> sigma;
}

transformed parameters {
  real mu[N];
  for (n in 1:N)
    mu[n] <- b1 + b2*Area[n];
}

model {
  for (n in 1:N)
    Y[n] ~ normal(mu[n], sigma);
}

generated quantities {
  real y_pred[N];
  real y_new[N_new];
  for (n in 1:N)
    y_pred[n] <- normal_rng(mu[n], sigma);
  for (n in 1:N_new)
    y_new[n] <- normal_rng(b1 + b2*Area_new[n], sigma);
}