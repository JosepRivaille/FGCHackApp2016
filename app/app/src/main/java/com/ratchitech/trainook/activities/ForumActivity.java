package com.ratchitech.trainook.activities;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.ratchitech.trainook.Constants;
import com.ratchitech.trainook.R;
import com.ratchitech.trainook.models.Entertainment;
import com.ratchitech.trainook.models.ForumDetails;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class ForumActivity extends AppCompatActivity {

    TextView nameTextView, descriptionTextView;
    ListView entriesListView;
    ProgressBar progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forum);

        nameTextView = (TextView) findViewById(R.id.forum_details_name);
        descriptionTextView = (TextView) findViewById(R.id.forum_details_description);
        entriesListView = (ListView) findViewById(R.id.forum_details_entries);
        progressBar = (ProgressBar) findViewById(R.id.forum_details_progress_bar);

        Intent intent = getIntent();
        String idForum = intent.getStringExtra("idForum");

        new GetForumDetails().execute(idForum);
    }

    private class GetForumDetails extends AsyncTask<String, Void, String> {

        @Override
        protected void onPreExecute() {
            progressBar.setVisibility(View.VISIBLE);
        }

        @Override
        protected String doInBackground(String... params) {
            String idForum = params[0];

            try {
                URL url = new URL(Constants.API_URL + "/forums/" + idForum + ".json");
                HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();

                Log.d("API_CONNECTION", String.format("%d", urlConnection.getResponseCode()));

                try {
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
                    StringBuilder buffer = new StringBuilder();

                    String line;
                    while ((line = bufferedReader.readLine()) != null) {
                        buffer.append(line).append('\n');
                    }

                    return buffer.toString();

                } finally {
                    urlConnection.disconnect();
                }
            } catch (Exception e) {
                Log.e("API_CONNECTION", "Connection error: " + e.getMessage());
                return null;
            }

        }

        @Override
        protected void onPostExecute(String response) {
            if (response != null) {
                try {
                    JSONObject forumJSONObject = new JSONObject(response);
                    String name = forumJSONObject.getString("name");
                    Integer visitors = forumJSONObject.getInt("visitors");
                    Integer participants = forumJSONObject.getInt("participants");

                    JSONObject entertainmentJSONObject = forumJSONObject.getJSONObject("entertainment");
                    String description = entertainmentJSONObject.getString("description");
                    String category = entertainmentJSONObject.getString("category");
                    Double score = entertainmentJSONObject.getDouble("score");

                    Entertainment entertainment = new Entertainment(description, category, score);
                    ForumDetails forumDetails = new ForumDetails(name, visitors, participants, entertainment);

                    nameTextView.setText(name);
                    descriptionTextView.setText(description);

                } catch (JSONException e) {
                    e.printStackTrace();
                }
            } else {
                Toast.makeText(ForumActivity.this, "Connection error", Toast.LENGTH_SHORT).show();
            }
            progressBar.setVisibility(View.GONE);
        }

    }

    //TODO: Implement
    private class GetForumEntries extends AsyncTask<String, Void, String> {

        @Override
        protected void onPreExecute() {

        }

        @Override
        protected String doInBackground(String... params) {
            return null;
        }

        @Override
        protected void onPostExecute(String response) {

        }

    }

}
