data {
  int N1;
  int N2;
  real Y1[N1];
  real Y2[N2];
}
parameters {
  real mu1;
  real mu2;
  real<lower=0> sigma;
}
model {
  for (n in 1:N1)
    Y1[n] ~ normal(mu1, sigma);
  for (n in 1:N2)
    Y2[n] ~ normal(mu2, sigma);
}
generated quantities {
  real mu_diff;
  mu_diff <- if_else(mu1 < mu2, 1, 0);
}
