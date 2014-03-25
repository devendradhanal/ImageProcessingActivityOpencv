package ${packageName};


import org.opencv.android.BaseLoaderCallback;
import org.opencv.android.LoaderCallbackInterface;
import org.opencv.android.OpenCVLoader;
import org.opencv.android.Utils;
import org.opencv.core.CvType;
import org.opencv.core.Mat;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.util.Log;
import android.view.Display;
import android.view.WindowManager;
import android.widget.ImageView;


import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
<#if parentActivityClass != "">
import android.view.MenuItem;
import android.support.v4.app.NavUtils;
<#if minApiLevel < 11>
import android.annotation.TargetApi;
import android.os.Build;
</#if>
</#if>

public class ${activityClass} extends Activity {
   
    boolean DEBUG = true;
    Bitmap photo;
    private static final String TAG = "${activityClass}";
    private Mat mRgba;
    int screenWidth, screenHeight;

    Bitmap scaledPhoto;
    Bitmap scaledPhotoMaster;

    float scaleFactorY;
    float scaleFactorX;

    float photoHeight;
    float photoWidth;
    int scaledPhotoHeight;
    int scaledPhotoWidth;

    ImageView image;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        setContentView(R.layout.${layoutName});

        // Add Image to root/res/drawable
        image = (ImageView) findViewById(R.id.handImage);

        Display display = getWindowManager().getDefaultDisplay();
        screenWidth = display.getWidth();
        screenHeight = display.getHeight();
        photo = CommonResource.bmA;    
        
        <#if parentActivityClass != "">
        // Show the Up button in the action bar.
        setupActionBar();
        </#if>
    }



    @Override
    protected void onResume() {
        super.onResume();

        // Add loading image border to root/res 
        photo = BitmapFactory.decodeResource(this.getResources(),
                R.drawable.loading_image_border);

        photo = CommonResource.bmA;
        OpenCVLoader.initAsync(OpenCVLoader.OPENCV_VERSION_2_4_5, this,
                mLoaderCallback);
    }

   

   private BaseLoaderCallback mLoaderCallback = new BaseLoaderCallback(this) {
        @Override
        public void onManagerConnected(int status) {
            switch (status) {
            case LoaderCallbackInterface.SUCCESS: {

                photo = CommonResource.bmA;

                scaleFactorY = (float) screenHeight / photo.getHeight();
                scaleFactorX = (float) screenWidth / photo.getWidth();

                if (DEBUG) {
                    Log.i(TAG, "screenHeight : " + screenHeight
                            + "screenWidth : " + screenWidth
                            + " photo.getHeight() " + photo.getHeight()
                            + " photo.getWidth() : " + photo.getWidth()
                            + "scaleFactorY : " + scaleFactorY
                            + " scaleFactorX : " + scaleFactorX);
                }

                photoHeight = photo.getHeight();
                photoWidth = photo.getWidth();

                scaledPhotoHeight = (int) (photoHeight * scaleFactorY);
                scaledPhotoWidth = (int) (photoWidth * scaleFactorX);

                scaledPhoto = Bitmap.createScaledBitmap(photo,
                        scaledPhotoWidth, scaledPhotoHeight, false);
                scaledPhotoMaster = Bitmap.createScaledBitmap(photo,
                        scaledPhotoWidth, scaledPhotoHeight, false);
                image.setImageBitmap(scaledPhoto);
                if (DEBUG) {
                    Log.i(TAG,
                            "Photo Dimensions => Height : " + photo.getHeight()
                                    + " Width : " + photo.getWidth());
                }

                mRgba = new Mat(photo.getHeight(), photo.getWidth(),
                        CvType.CV_8UC4);
                Utils.bitmapToMat(scaledPhoto, mRgba);
                /* Process mRgba using OpenCV here */
                //
                //
                //
                //
                //
                //
                /* Process mRgba using OpenCV here */
                Utils.matToBitmap(mRgba, scaledPhoto);

                image.setImageBitmap(scaledPhoto);

            }
                break;
            case LoaderCallbackInterface.INCOMPATIBLE_MANAGER_VERSION: {
                photo = CommonResource.bmA;
                image.setImageBitmap(photo);
            }
            default: {
                super.onManagerConnected(status);
                 photo = CommonResource.bmA;
                 image.setImageBitmap(photo);
            }
                break;
            }
        }
    };



    
    <#if parentActivityClass != "">
    /**
     * Set up the {@link android.app.ActionBar}<#if minApiLevel < 11>, if the API is available</#if>.
     */
    <#if minApiLevel < 11>@TargetApi(Build.VERSION_CODES.HONEYCOMB)
    </#if>private void setupActionBar() {
        <#if minApiLevel < 11>if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {</#if>
        getActionBar().setDisplayHomeAsUpEnabled(true);
        <#if minApiLevel < 11>}</#if>
    }
    </#if>

   void releaseMats() {
        mRgba.release();
    }


    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onRestart() {
        super.onRestart();
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    protected void onStop() {
        super.onStop();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         releaseMats();
    }
    

    <#include "include_onCreateOptionsMenu.java.ftl">
    <#include "include_onOptionsItemSelected.java.ftl">

}
