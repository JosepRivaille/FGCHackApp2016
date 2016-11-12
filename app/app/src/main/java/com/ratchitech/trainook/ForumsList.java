package com.ratchitech.trainook;

import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.ratchitech.trainook.models.ForumSimple;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class ForumsList extends AppCompatActivity {

    private ListView listView;
    private ProgressBar progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_forums_list);

        listView = (ListView) findViewById(R.id.forums_list);
        progressBar = (ProgressBar) findViewById(R.id.forums_progress_bar);

        new GetAllForums().execute();
    }

    private Boolean exit = false;
    @Override
    public void onBackPressed() {
        if (exit) {
            finish();
        } else {
            Toast.makeText(this, "Press back again to exit", Toast.LENGTH_SHORT).show();
            exit = true;
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    exit = false;
                }
            }, 3000);
        }
    }

    private class GetAllForums extends AsyncTask<Void, Void, String> {

        @Override
        protected void onPreExecute() {
            progressBar.setVisibility(View.VISIBLE);
        }

        @Override
        protected String doInBackground(Void... params) {
            return "[\n" +
                    "  {\n" +
                    "    \"name\": \"asdasd\",\n" +
                    "    \"category\": \"films\",\n" +
                    "    \"valoration\": 8\n" +
                    "  },\n" +
                    "  {\n" +
                    "    \"name\": \"123\",\n" +
                    "    \"category\": \"films\",\n" +
                    "    \"valoration\": 8\n" +
                    "  },\n" +
                    "  {\n" +
                    "    \"name\": \"asd\",\n" +
                    "    \"category\": \"films\",\n" +
                    "    \"valoration\": 8\n" +
                    "  }\n" +
                    "]";

            /*try {
                String u = Constants.API_URL;
                URL url = new URL(u);
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
            }*/
        }

        @Override
        protected void onPostExecute(String response) {
            if (response != null) {
                try {
                    final List<ForumSimple> forumsSimples = new ArrayList<>();

                    JSONArray forumsJSONArray = new JSONArray(response);
                    int forumsSize = forumsJSONArray.length();
                    for (int i = 0; i < forumsSize; i++) {
                        JSONObject forumSimpleJSONObject = forumsJSONArray.getJSONObject(i);
                        String name = forumSimpleJSONObject.getString("name");
                        String category = forumSimpleJSONObject.getString("category");
                        Double valoration = forumSimpleJSONObject.getDouble("valoration");
                        ForumSimple forumSimple = new ForumSimple(name, category, valoration);
                        forumsSimples.add(forumSimple);
                    }

                    final ArrayAdapter<ForumSimple> adapter = new ArrayAdapter<ForumSimple>(
                            ForumsList.this, android.R.layout.simple_expandable_list_item_2,
                            android.R.id.text1, forumsSimples) {

                        @Override
                        public View getView(int position, View convertView, ViewGroup parent) {
                            View view = super.getView(position, convertView, parent);

                            TextView text1 = (TextView) view.findViewById(android.R.id.text1);
                            TextView text2 = (TextView) view.findViewById(android.R.id.text2);

                            String name = forumsSimples.get(position).getName();
                            String category = forumsSimples.get(position).getCategory();

                            text1.setText(name);
                            text2.setText(category);

                            return view;
                        }
                    };

                    listView.setAdapter(adapter);

                } catch (JSONException e) {
                    Toast.makeText(ForumsList.this, "Invalid data", Toast.LENGTH_SHORT).show();
                }
            } else {
                Toast.makeText(ForumsList.this, "Connection error", Toast.LENGTH_SHORT).show();
            }

            progressBar.setVisibility(View.GONE);
        }

    }

}
