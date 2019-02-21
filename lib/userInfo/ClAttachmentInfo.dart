
/// create by shenhq on 2018/10/25.
class ClAttachmentInfo {

     String biz_order_no;

     String file_name;

     String file_path;

     String file_size;

     String file_suffix;

     String file_type;

     String is_image;

     String fast_dfs_path;

     int upload_count;

     String create_date;

     String has_update;

    /// 0：小程序页面进单，直接插入到wx_attachment_info表  1：插入wx_attachment_info_temp
     int formType;

    /// 1：微信表 2：正式表
     int channel_type;

}
