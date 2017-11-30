import tweepy

consumer_key = "y3FSzjpBwaCqlPd9JFws64Mdy";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "yiCiGgMVaRegZBeGcl8cGkCPX8JHQYitUeuI4qBijPNtpJk9HL";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "924354335114272768-HO385GSfX1Rf90MLOHW1YAY1p4wlEz3";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "qlmdWWitsnDUdO2LSrl3Svsv0zF9UgvkHtaQ0y9lA7FwW";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



