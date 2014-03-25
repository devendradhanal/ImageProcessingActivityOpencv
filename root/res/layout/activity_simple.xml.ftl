<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
             xmlns:tools="http://schemas.android.com/tools"
    android:layout_width=<#if buildApi lt 8 >"fill_parent"<#else>"match_parent"</#if>
    android:layout_height=<#if buildApi lt 8 >"fill_parent"<#else>"match_parent"</#if>
    android:orientation="vertical"
    tools:context=".${activityClass}" >

    <ImageView
        android:id="@+id/handImage"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerInParent="true"
        android:scaleType="matrix"
        android:src="@drawable/loading_image_border" />

</FrameLayout>
