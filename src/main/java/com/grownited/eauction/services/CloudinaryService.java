package com.grownited.eauction.services;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.Map;

@Service
public class CloudinaryService {
    
    private Cloudinary cloudinary;
    
    @Value("${cloudinary.cloud-name}")
    private String cloudName;
    
    @Value("${cloudinary.api-key}")
    private String apiKey;
    
    @Value("${cloudinary.api-secret}")
    private String apiSecret;
    
    private Cloudinary getCloudinary() {
        if (cloudinary == null) {
            cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret));
        }
        return cloudinary;
    }
    
    public String uploadImage(MultipartFile file) throws IOException {
        Map uploadResult = getCloudinary().uploader().upload(file.getBytes(), ObjectUtils.emptyMap());
        return (String) uploadResult.get("url");
    }
    
    public Map deleteImage(String imageUrl) throws IOException {
        String publicId = extractPublicId(imageUrl);
        return getCloudinary().uploader().destroy(publicId, ObjectUtils.emptyMap());
    }
    
    private String extractPublicId(String imageUrl) {
        // Extract public ID from Cloudinary URL
        String[] parts = imageUrl.split("/");
        String lastPart = parts[parts.length - 1];
        return lastPart.substring(0, lastPart.lastIndexOf('.'));
    }
}