// for exercise 2
data {
  int N;
  int G[N];
  real Y[N];
}

parameters {
  real b1;
  real b2;
  real b3;
  real b4;
}

transformed parameters {
  real mu[N];
  real<lower=0> sigma[N];
  
  for (n in 1:N)
    mu[n] = b1 + b2*G[n];
  
  for (n in 1:N)
    sigma[n] = b3 + b4*G[n];
}

model {
  for (n in 1:N)
    Y[n] ~ normal(mu[n], sigma[n]);
}
