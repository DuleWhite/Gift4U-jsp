package util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PageConnectionManager {
    private static Map<String,String> pageConnection;
    static{
        pageConnection = new HashMap<>();
        pageConnection.put("../index","Home");
        pageConnection.put("products","Products");
        pageConnection.put("orders","Orders");
        pageConnection.put("cart","Cart");
    }
    public static String getPageName(String pathName){
        return pageConnection.get(pathName);
    }
}
