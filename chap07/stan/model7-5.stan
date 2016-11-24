data {
  int N;
  real Weight[N];
  real Age[N];
  real Y[N];
}

parameters {
  real c1;
  real c2;
  real<lower=0> sigma_w;
  real b1;
  real b2;
  real b3;
  real<lower=0> sigma_y;
}

model {
  for (n in 1:N) {
    Weight[n] ~ normal(c1 + c2*Age[n], sigma_w);
    Y[n] ~ normal(b1+b2*Age[n]+b3*Weight[n], sigma_y);
  }
}
