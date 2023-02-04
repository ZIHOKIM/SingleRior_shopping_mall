package com.E1I4.project.member.model.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.stereotype.Service;


@Service
public class NaverLogin {
	public String getAccessToken(String code) {
		String accessToken = "";
		String reqURL ="https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id=csSoyGLeoDJrrYsbQ_Vt&client_secret=Dalx0jMruX&code="+code+"&state=singlerior";  
		
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
            
			JSONObject jObject = new JSONObject(result);
//			System.out.println(jObject);
			
			accessToken = jObject.getString("access_token");
//			System.out.println(accessToken);
			
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return accessToken;
	}

	public HashMap<String, Object> getUserInfo(String accessToken) {
		
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
            
			while ((line = br.readLine()) != null) {
				result += line;
			}
            
			
			JSONObject jObject = new JSONObject(result);
			
			JSONObject response = jObject.getJSONObject("response");
//			System.out.println(jObject);
//			System.out.println(response);
			
			String memberId = response.getString("id");
			
			String nickname = response.getString("nickname");
			String email = response.getString("email");
			String phone = response.getString("mobile");
			String memberName = response.getString("name");
			
			userInfo.put("memberId", memberId);
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
			userInfo.put("phone", phone);
			userInfo.put("memberName", memberName);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return userInfo;
	}
}
