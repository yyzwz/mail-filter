package cn.zwz.xboot.modules.tricycle.utils;

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.WritableRaster;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageSmallUtils {
    public static void main(String[] args) {
        File wjjSum = new File("D:\\测试");
        File[] wjjList = wjjSum.listFiles(); // 文件夹
        for (File wjj : wjjList) {
            String path = wjj.getAbsolutePath(); // D:\测试\长街030326
            String name = wjj.getName();  // 长街030326
            File file = new File(path); // D:\测试\长街030326
            File[] fileList = file.listFiles(); // D:\测试\长街030326\长街0303260.png *3
            for(int i = 0 ; i < fileList.length ; i ++) {
                if(fileList[i] != null) {
                    String absolutePath = fileList[i].getAbsolutePath(); // D:\测试\长街030326\长街0303260.png
                    reSize(new File(absolutePath),new File(absolutePath),800,800,true);
                }
            }
        }
    }

    /**
     * @param srcImg     原图片
     * @param destImg    目标位置
     * @param width      期望宽
     * @param height     期望高
     * @param equalScale 是否等比例缩放
     */
    public static void reSize(File srcImg, File destImg, int width,
                              int height, boolean equalScale) {
        String type = getImageType(srcImg);
        if (type == null) {
            return;
        }
        if (width < 0 || height < 0) {
            return;
        }

        BufferedImage srcImage = null;
        try {
            srcImage = ImageIO.read(srcImg);
            System.out.println("srcImg size=" + srcImage.getWidth() + "X" + srcImage.getHeight());
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
        if (srcImage != null) {
            // targetW，targetH分别表示目标长和宽
            BufferedImage target = null;
            double sx = (double) width / srcImage.getWidth();
            double sy = (double) height / srcImage.getHeight();
            // 等比缩放
            if (equalScale) {
                if (sx > sy) {
                    sx = sy;
                    width = (int) (sx * srcImage.getWidth());
                } else {
                    sy = sx;
                    height = (int) (sy * srcImage.getHeight());
                }
            }
            System.out.println("destImg size=" + width + "X" + height);
            ColorModel cm = srcImage.getColorModel();
            WritableRaster raster = cm.createCompatibleWritableRaster(width, height);
            boolean alphaPremultiplied = cm.isAlphaPremultiplied();

            target = new BufferedImage(cm, raster, alphaPremultiplied, null);
            Graphics2D g = target.createGraphics();
            // smoother than exlax:
            g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            g.drawRenderedImage(srcImage, AffineTransform.getScaleInstance(sx, sy));
            g.dispose();
            // 将转换后的图片保存
            try {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(target, type, baos);
                FileOutputStream fos = new FileOutputStream(destImg);
                fos.write(baos.toByteArray());
                fos.flush();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 获取文件后缀不带.
     *
     * @param file 文件后缀名
     * @return
     */
    private static String getImageType(File file) {
        if (file != null && file.exists() && file.isFile()) {
            String fileName = file.getName();
            int index = fileName.lastIndexOf(".");
            if (index != -1 && index < fileName.length() - 1) {
                return fileName.substring(index + 1);
            }
        }
        return null;
    }
}