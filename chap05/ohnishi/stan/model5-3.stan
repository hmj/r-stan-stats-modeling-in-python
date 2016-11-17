data {
  int N;
  int N_new;
  int<lower=0, upper=1> A[N];
  real<lower=0, upper=1> Score[N];
  real<lower=0, upper=1> Y[N];
  real<lower=0, upper=1> Score_new[N_new];
}

parameters {
  real b1;
  real b2;
  real b3;
  real <lower=0> sigma;
}

transformed parameters {
  real mu[N];
  for (n in 1:N)
    mu[n] <- b1 + b2*A[n] + b3*Score[n];
}

model {
  for (n in 1:N)
    Y[n] ~ normal(mu[n], sigma);
}

generated quantities {
  real y_pred[N];
  real mu0_new[N_new];
  real mu1_new[N_new];
  real y0_pred[N_new];
  real y1_pred[N_new];
  for (n in 1:N)
    y_pred[n] <- normal_rng(mu[n], sigma);
    
  for (n in 1:N_new) { 
    mu0_new[n] <- b1 + b3*Score_new[n];
    mu1_new[n] <- b1 + b2 +  b3*Score_new[n];
    y0_pred[n] <- normal_rng(mu0_new[n], sigma);
    y1_pred[n] <- normal_rng(mu1_new[n], sigma);
  }
}