package com.E1I4.project.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoLogin {

	// 카카오 로그인
		public String getAccessToken(String code) {
			
			String accessToken = "";
			String reqURL = "https://kauth.kakao.com/oauth/token";
			
			try {
				URL url = new URL(reqURL);
				
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				
				conn.setRequestMethod("POST");
				conn.setDoOutput(true);
				
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				StringBuilder sb = new StringBuilder();
				
				sb.append("grant_type=authorization_code");
	            
				sb.append("&client_id=3511f863b828fb1a348dbb6100a0ddb0"); //본인이 발급받은 key
				sb.append("&redirect_uri=http://localhost:8088/SingleRior/kakaoLogin.me"); // 본인이 설정한 주소
	            
				sb.append("&code=" + code);
				bw.write(sb.toString());
				bw.flush();
				
//				System.out.println("responseCode : " + responseCode);
				
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				String result = "";
	            
				while ((line = br.readLine()) != null) {
					result += line;
				}
	            
				JSONObject jObject = new JSONObject(result);
				accessToken = jObject.getString("access_token");
				
//				System.out.println(accessToken);
	            
				br.close();
				bw.close();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return accessToken;
		}

		public HashMap<String, Object> getUserInfo(String accessToken) {
			HashMap<String, Object> userInfo = new HashMap<String, Object>();
			String reqURL = "https://kapi.kakao.com/v2/user/me";
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
//				System.out.println("response body : " + result);

				JSONObject jObject = new JSONObject(result);
				
				JSONObject properties = jObject.getJSONObject("properties");
				JSONObject kakao_account = jObject.getJSONObject("kakao_account");
				
				long idlong = (long)jObject.get("id");
				String id = Long.toString(idlong);
				
				String nickName = properties.getString("nickname");
				String email = kakao_account .getString("email");
//				System.out.println("nickName"+nickName);
//				System.out.println("id" +id);
//				System.out.println("email" +email);
				

				userInfo.put("nickname", nickName);
				userInfo.put("email", email);
				userInfo.put("kakaoId", id);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return userInfo;
		}
	
	
}
