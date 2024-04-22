package javajedik.main.util;

import java.util.HashMap;
import java.util.Map;

public class LanguageDict 
{
    private static final Map<String, String> languageMap = new HashMap<>();

    static 
    {
        languageMap.put("hun", "Hungarian");
        languageMap.put("eng", "English");
        // Ide írd további nyelvek leképzéseit...
    }

    public static String getLanguage(String code) {
        String lowercaseCode = code.toLowerCase();
        return languageMap.getOrDefault(lowercaseCode, "eng");
    }
}
