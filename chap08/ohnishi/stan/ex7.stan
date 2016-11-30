data {
  int N;
  int L;
  int F[N];
  int<lower=0> Y[N];
  int<lower=1, upper=L> N2L[N];
}

parameters {
  real b[2];
  real<lower=0> s_y;
  real b_y[N];
  real<lower=0> s_l;
  real b_l[L];
}

transformed parameters {
  real<lower=0> lambda[N];
  for (n in 1:N) {
    lambda[n] = exp(b[1] + b[2]*F[n] + b_y[n] + b_l[N2L[n]]);
  }
  
}

model {
  for (n in 1:N)
    b_y[n] ~ normal(0, s_y);
    
  for (l in 1:L)
    b_l[l] ~ normal(0, s_l);
  
  for (n in 1:N)
    Y[n] ~ poisson(lambda[n]);
}