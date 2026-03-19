package com.grownited.eauction.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Service
public class CloudinaryService {

    private Cloudinary cloudinary;
    
    @Value("${cloudinary.cloud-name:}")
    private String cloudName;
    
    @Value("${cloudinary.api-key:}")
    private String apiKey;
    
    @Value("${cloudinary.api-secret:}")
    private String apiSecret;

    private Cloudinary getCloudinary() {
        if (cloudinary == null) {
            if (cloudName.isEmpty() || apiKey.isEmpty() || apiSecret.isEmpty()) {
                // Return null if Cloudinary is not configured
                return null;
            }
            Map<String, String> config = new HashMap<>();
            config.put("cloud_name", cloudName);
            config.put("api_key", apiKey);
            config.put("api_secret", apiSecret);
            cloudinary = new Cloudinary(config);
        }
        return cloudinary;
    }

    /**
     * Upload single image to Cloudinary
     */
    public String uploadImage(MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }
        
        Cloudinary cloudinary = getCloudinary();
        if (cloudinary == null) {
            // Return placeholder if Cloudinary not configured
            return "/assets/images/default-product.jpg";
        }
        
        Map uploadResult = cloudinary.uploader().upload(
            file.getBytes(), 
            ObjectUtils.asMap(
                "folder", "eauction/products",
                "resource_type", "auto"
            )
        );
        
        return uploadResult.get("secure_url").toString();
    }

    /**
     * Upload multiple images to Cloudinary
     */
    public String[] uploadMultipleImages(MultipartFile[] files) throws IOException {
        if (files == null || files.length == 0) {
            return new String[0];
        }
        
        String[] urls = new String[files.length];
        for (int i = 0; i < files.length; i++) {
            if (files[i] != null && !files[i].isEmpty()) {
                urls[i] = uploadImage(files[i]);
            }
        }
        return urls;
    }

    /**
     * Delete image from Cloudinary
     */
    public Map deleteImage(String imageUrl) throws IOException {
        Cloudinary cloudinary = getCloudinary();
        if (cloudinary == null || imageUrl == null || imageUrl.isEmpty()) {
            return null;
        }
        
        // Extract public ID from URL
        String publicId = extractPublicId(imageUrl);
        if (publicId != null) {
            return cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());
        }
        return null;
    }

    /**
     * Extract public ID from Cloudinary URL
     */
    private String extractPublicId(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return null;
        }
        
        try {
            // Format: https://res.cloudinary.com/cloud-name/image/upload/v1234567890/folder/public_id.jpg
            String[] parts = imageUrl.split("/");
            String fileName = parts[parts.length - 1];
            String folder = parts[parts.length - 2];
            
            // Remove file extension
            String publicId = fileName.substring(0, fileName.lastIndexOf('.'));
            
            return folder + "/" + publicId;
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Get optimized image URL with transformations
     */
    public String getOptimizedImageUrl(String imageUrl, int width, int height) {
        if (imageUrl == null || imageUrl.isEmpty()) {
            return "/assets/images/default-product.jpg";
        }
        
        if (!imageUrl.contains("cloudinary")) {
            return imageUrl;
        }
        
        try {
            // Add transformation parameters to Cloudinary URL
            return imageUrl.replace("/upload/", "/upload/w_" + width + ",h_" + height + ",c_fill/");
        } catch (Exception e) {
            return imageUrl;
        }
    }

    /**
     * Validate if file is an image
     */
    public boolean isValidImage(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return false;
        }
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");
    }

    /**
     * Get file size in MB
     */
    public double getFileSizeInMB(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            return 0;
        }
        return file.getSize() / (1024.0 * 1024.0);
    }
}