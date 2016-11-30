data {
  int N;
  int<lower=0, upper=8> Y[N];
  int M;
}

parameters {
  real b;
  real r[N];
  real<lower=0> s_r;
}

transformed parameters {
  real q[N];
  for (n in 1:N)
    q[n] = inv_logit(b + r[n]);
}

model {
  for (n in 1:N) 
    r[n] ~ normal(0, s_r);
  for (n in 1:N) 
    Y[n] ~ binomial(M, q[n]);
}
