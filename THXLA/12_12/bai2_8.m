grain=imcrop(labeled)
RGB_label=label2rgb(labeled, @spring,'c','shuffle');
imshow(RGB_label);