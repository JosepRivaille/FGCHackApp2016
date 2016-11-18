package com.ratchitech.trainook.fragments;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.ratchitech.trainook.Constants;
import com.ratchitech.trainook.R;
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

public class AllForumsListMainMenu extends Fragment {

    private ListView listView;
    private ProgressBar progressBar;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.activity_all_forums_list, container, false);

        listView = (ListView) rootView.findViewById(R.id.forums_list);
        progressBar = (ProgressBar) rootView.findViewById(R.id.forums_progress_bar);

        return rootView;
    }

    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        new GetAllForums().execute();
    }

    private class GetAllForums extends AsyncTask<Void, Void, String> {

        @Override
        protected void onPreExecute() {
            progressBar.setVisibility(View.VISIBLE);
        }

        @Override
        protected String doInBackground(Void... params) {

            try {
                URL url = new URL(Constants.API_URL + "/forums.json");
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
                    final List<ForumSimple> forumsSimples = new ArrayList<>();

                    JSONArray forumsJSONArray = new JSONArray(response);
                    int forumsSize = forumsJSONArray.length();
                    for (int i = 0; i < forumsSize; i++) {
                        JSONObject forumSimpleJSONObject = forumsJSONArray.getJSONObject(i);
                        Integer idForum = forumSimpleJSONObject.getInt("id");
                        String name = forumSimpleJSONObject.getString("name");
                        String category = forumSimpleJSONObject.getString("category");
                        Double score = forumSimpleJSONObject.getDouble("score");
                        ForumSimple forumSimple = new ForumSimple(idForum, name, category, score);
                        forumsSimples.add(forumSimple);
                    }

                    final ArrayAdapter<ForumSimple> adapter = new ArrayAdapter<ForumSimple>(
                            getContext(), R.layout.forum_simple_item_list,
                            R.id.text_title, forumsSimples) {

                        @Override
                        public View getView(int position, View convertView, ViewGroup parent) {
                            View view = super.getView(position, convertView, parent);

                            ImageView imageCategory = (ImageView) view.findViewById(R.id.forum_simple_category_image);
                            TextView textTitle = (TextView) view.findViewById(R.id.text_title);
                            TextView textScore = (TextView) view.findViewById(R.id.text_score);

                            String name = forumsSimples.get(position).getName();
                            String category = forumsSimples.get(position).getCategory();
                            Double score = forumsSimples.get(position).getValoration();

                            imageCategory.setImageResource(getIconFromCategory(category));
                            textTitle.setText(name);
                            textScore.setText(String.format("%.2f", score));

                            return view;
                        }

                        private int getIconFromCategory(String category) {
                            switch (category) {
                                case "cinema":
                                    return R.drawable.cinema_icon;
                                case "sports":
                                    return R.drawable.sports_icon;
                                case "music":
                                    return R.drawable.music_icon;
                                case "games":
                                    return R.drawable.games_icon;
                                case "books":
                                    return R.drawable.books_icon;
                                default:
                                    return R.drawable.default_icon;
                            }
                        }
                    };

                    listView.setAdapter(adapter);

                } catch (JSONException e) {
                    Toast.makeText(getContext(), "Invalid data", Toast.LENGTH_SHORT).show();
                }
            } else {
                Toast.makeText(getContext(), "Connection error", Toast.LENGTH_SHORT).show();
            }
            progressBar.setVisibility(View.GONE);
        }
    }

}
