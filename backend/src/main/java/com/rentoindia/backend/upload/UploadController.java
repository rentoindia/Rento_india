package com.rentoindia.backend.upload;

import com.rentoindia.backend.common.ApiException;
import com.rentoindia.backend.common.ApiResponse;
import com.rentoindia.backend.common.Obj;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

/**
 * Stores uploaded images/videos/PDFs on the server disk and returns a URL like /files/<name>.
 * (Swap the body for S3 later - the apps only ever store the returned URL.)
 * POST /api/v1/uploads  (multipart/form-data, field name "file")
 */
@RestController
@RequestMapping("/api/v1/uploads")
public class UploadController {

    private static final Set<String> ALLOWED = Set.of("jpg", "jpeg", "png", "webp", "gif", "mp4", "mov", "pdf");

    private final Path dir;

    public UploadController(@Value("${app.upload-dir:uploads}") String uploadDir) throws IOException {
        this.dir = Paths.get(uploadDir).toAbsolutePath().normalize();
        Files.createDirectories(dir);
    }

    @PostMapping
    public ApiResponse<Obj> upload(@RequestParam("file") MultipartFile file) throws IOException {
        if (file == null || file.isEmpty()) throw ApiException.badRequest("No file received");
        String original = file.getOriginalFilename() == null ? "file" : file.getOriginalFilename();
        int dot = original.lastIndexOf('.');
        String ext = dot >= 0 ? original.substring(dot + 1).toLowerCase(Locale.ROOT) : "";
        if (!ALLOWED.contains(ext)) throw ApiException.badRequest("This file type is not allowed");
        String name = UUID.randomUUID() + "." + ext;
        Files.copy(file.getInputStream(), dir.resolve(name), StandardCopyOption.REPLACE_EXISTING);
        return ApiResponse.ok(Obj.of().with("url", "/files/" + name).with("name", name).with("size", file.getSize()));
    }

    public Path directory() {
        return dir;
    }
}
