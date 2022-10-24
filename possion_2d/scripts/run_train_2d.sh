cd ..

config_dir="src/config"
save_dir="checkpoints/"
n_epoch=600

python train.py $config_dir/dataset_rectangle.yml $config_dir/model_2d.yml --save_dir=$save_dir --n_epoch=$n_epoch
python train.py $config_dir/dataset_disk.yml $config_dir/model_2d.yml --save_dir=$save_dir --n_epoch=$n_epoch
python train.py $config_dir/dataset_triangle.yml $config_dir/model_2d.yml --save_dir=$save_dir --n_epoch=$n_epoch
python train.py $config_dir/dataset_pentagon.yml $config_dir/model_2d.yml --save_dir=$save_dir --n_epoch=$n_epoch

