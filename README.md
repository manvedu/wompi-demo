# Welcome Wompi's tokenizer!

Hi! 

Using this project you can create tokens in Wompi and with that token create a payment source. 
For the tokenization this projects uses the [widget](https://docs.wompi.co/docs/en-us/fuentes-de-pago#widget-in-tokenization-mode) provided by Wompi.

# Dependencies


# Installation
- Clone project from **git@github.com:manvedu/wompi-demo.git**
- Install bundler `gem install bundler`
- Install gems ` bundle`


## Run app
1. Create your `.env` file with this structure
```
MERCHANT_PUBLIC_KEY=pub_XXX_XXXXXXXXXXXXXX #Merchant's public key provided by Wompi used for tokenization and get acceptance token
MERCHANT_PRIVATE_KEY=prv_XXX_XXXXXXXXXXXXX #Merchant's private key provided by Wompi used to create payment source
WOMPI_HOST=https://sandbox.wompi.co/v1/ #Wompi url for sandbox
```

You can find all the information about Wompi's enviroments and/or keys in this [link](https://docs.wompi.co/docs/en-us/ambientes-y-llaves)


2. Run command

```
dotenv -f .env rails s
```

Now your app is running at localhost:3000

3. open in your browser `localhost:3000` and test it.


# Details
This app shows the button generated by the widget in the root view. You can find it in `app/views/subscriptions/new.html.erb`

![image](https://user-images.githubusercontent.com/11188064/143105675-0de197a5-055f-4fe2-87f6-6ed850398679.png)


When you tokenize your card, this information is sent to the action set in the html form `my_own_process_token`
this action is set as `post "my_own_process_token", to: "subscriptions#create"` in the `config/routes` so you receive a paramater called `payment_source_token` with the token generated in Wompi.

With this token we call the `Wompi::Client` found in `lib/wompi/client.rb` which creates the payment source.

The `Wompi::Client` ask for the acceptance_token and with the acceptance_token and the token from `payment_source_token` creates the payment source as[Wompi's documentation](https://docs.wompi.co/docs/en-us/fuentes-de-pago)suggests .

When the payment source is success the action `create` in the  controller `app/controllers/subscriptions_controller.rb` make a redirection to 
[Google search](https://google.com).
