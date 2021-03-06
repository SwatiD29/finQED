#include <oxstd.h>
#import "financialNR"

test_binomial_pricing()
{
    println("START testing Binomial Pricing");
    decl spot = 100.0;
    decl exercise = 100.0;
    decl r = 0.1;
    decl sigma = 0.25;
    decl time_to_maturity=1.0;
    decl steps = 100;
    println(" european ");
    println(" call: ", option_price_call_european_binomial(spot,exercise,r,sigma,time_to_maturity,steps) );
	println(" put: ", option_price_put_european_binomial(spot,exercise,r,sigma,time_to_maturity,steps) );
    println(" american ");
    println(" call: ", option_price_call_american_binomial(spot,exercise,r,sigma,time_to_maturity,steps) );
    println(" put: ", option_price_put_american_binomial(spot,exercise,r,sigma,time_to_maturity,steps) );
    decl dividend_times = <0.25,0.75>;

    decl dividend_yields = <0.03,0.03>;

    println("Proportional dividends ");
    println(" american call, dividends=3%, 3%, price= ",
		option_price_call_american_proportional_dividends_binomial(
	    	spot,exercise,r,sigma,time_to_maturity,steps,
	     	dividend_times, dividend_yields) );
    println(" american put, dividends=3%, 3%, price= ",
		option_price_put_american_proportional_dividends_binomial(
	    	spot,exercise,r,sigma,time_to_maturity,steps,
	     	dividend_times, dividend_yields) );

    decl dividend_amounts = <2.5,2.5>;

    println("Discrete dividends: " );
    println(" american call, dividends 2.5 2.5, price= ",
		option_price_call_american_discrete_dividends_binomial(
	    	spot,exercise,r,sigma,time_to_maturity,steps,
	    	dividend_times, dividend_amounts) );
    println(" american put, dividends 2.5 2.5, price= ",
		option_price_put_american_discrete_dividends_binomial(
	    	spot,exercise,r,sigma,time_to_maturity,steps,
	    	dividend_times, dividend_amounts) );
    println("DONE testing binomial pricing ");
}
test_binomial_partials()
{
    println("START testing binomial partials ");
    decl S = 100.0;
    decl X = 100.0;
    decl r = 0.1;
    decl sigma = 0.25;
    decl time = 1.0;
    decl no_steps=100;
    println(" american call delta = ",
		option_price_delta_american_call_binomial(S,X,r,sigma,time, no_steps) );
    println(" american put delta = ",
		option_price_delta_american_put_binomial(S,X,r,sigma,time, no_steps) );
    decl delta, gamma, theta, vega, rho;
    option_price_partials_american_call_binomial(S,X,r, sigma, time, no_steps,
		&delta, &gamma, &theta, &vega, &rho);
    println("CALL price partials ");
    println(" Delta = ", delta);
    println(" gamma = ", gamma);
    println(" theta = ", theta);
    println(" vega  = ", vega);
    println(" rho   = ", rho);
    option_price_partials_american_put_binomial(S,X,r, sigma, time, no_steps,
		&delta, &gamma, &theta, &vega, &rho);
    println("PUT price partials");
    println(" Delta = ", delta);
    println(" gamma = ", gamma);
    println(" theta = ", theta);
    println(" vega  = ", vega);
    println(" rho   = ", rho);
    println("DONE testing binomial partials ");
}
main()
{
	test_binomial_pricing();
	test_binomial_partials();
}
