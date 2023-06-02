package com.big.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class AuthCode {
    /**
     * This method generates a secure string used as the PKCE code verifier value.
     * In PKCE, you use the code verifier value:
     * 1. When you generate a code challenge value.
     * 2. When you exchange an authorization code for a bearer JWT token.
     * @return A random code verifier value.
     */
    final public String generateCodeVerifier() {

        SecureRandom secureRandom = new SecureRandom();
        byte[] bytes = new byte[36];
        secureRandom.nextBytes(bytes);

        String result = Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
        //System.out.println("code verifier = " + result);
        return result;
    }


    /**
     * This method generates a code challenge value by SHA-256 and base64 encoding the code verifier value.
     * In PKCE, you use the code challenge value when you construct the authorization request uri.
     * @param codeVerifierValue A random string value.
     * @return An encoded code challenge string value.
     * @throws NoSuchAlgorithmException
     */
    public String generateCodeChallengeHash(String codeVerifierValue) throws NoSuchAlgorithmException {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
        byte[] codeVerifierBytes = codeVerifierValue.getBytes(StandardCharsets.US_ASCII);
        byte[] digest = messageDigest.digest(codeVerifierBytes);

        return Base64.getUrlEncoder().withoutPadding().encodeToString(digest);
    }

   public String generateCodeChallenge(String cV){


      // System.out.println("code verifier in cC method = " + cV);
       String result;
       try {
           result = generateCodeChallengeHash(cV);
       } catch (NoSuchAlgorithmException e) {
           throw new RuntimeException(e);
       }

      //System.out.println("generated Code Challenge = " + result);
       return result;
   }

}