#include <stdio.h>
#include <png.h>

int main(int argc, char const *argv[])
{
    FILE *png_file = fopen("test.png", "wb");
    png_structp png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING,
                                                  (png_voidp)user_error_ptr,
                                                  user_error_fn,
                                                  user_warning_fn);
    if (NULL == png_ptr)
    {
        return 1;
    }

    png_infop info_ptr = png_create_info_struct(png_ptr);
    if (NULL == info_ptr)
    {
        png_destroy_write_struct(&png_ptr, png_infopp)NULL);
        return 1;
    }



    return 0;
}
