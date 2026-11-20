package com.rentoindia.backend.common;

import java.util.LinkedHashMap;

/** Tiny JSON-object builder that (unlike Map.of) allows null values. */
public class Obj extends LinkedHashMap<String, Object> {

    public static Obj of() {
        return new Obj();
    }

    public Obj with(String key, Object value) {
        super.put(key, value);
        return this;
    }
}
