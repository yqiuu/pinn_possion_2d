cd ..

config_dir="src/config"
ckpt_dir="checkpoints_done"

python eval.py $config_dir/dataset_rectangle.yml $config_dir/model_2d.yml $ckpt_dir/possion_2d_rectangle.ckpt
python eval.py $config_dir/dataset_disk.yml $config_dir/model_2d.yml $ckpt_dir/possion_2d_disk.ckpt
python eval.py $config_dir/dataset_triangle.yml $config_dir/model_2d.yml $ckpt_dir/possion_2d_triangle.ckpt
python eval.py $config_dir/dataset_pentagon.yml $config_dir/model_2d.yml $ckpt_dir/possion_2d_pentagon.ckpt

