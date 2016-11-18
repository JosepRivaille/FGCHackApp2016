package com.ratchitech.trainook.activities;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.method.LinkMovementMethod;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.ratchitech.trainook.BuildConfig;
import com.ratchitech.trainook.R;

public class AboutActivity extends AppCompatActivity {

    TextView version, description;
    ImageView backArrow;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about);

        description = (TextView) findViewById(R.id.description);
        version = (TextView) findViewById(R.id.version);
        backArrow = (ImageView) findViewById(R.id.back);

        description.setClickable(true);
        description.setMovementMethod(LinkMovementMethod.getInstance());

        String versionName = BuildConfig.VERSION_NAME;
        version.setText(versionName);

        backArrow.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
    }

}
