use std::fs::File;
use std::io::{BufReader, Write};
use std::path::Path;
use std::process::Command;

use async_std::task;
use reqwest::blocking::Client;
use toml::Value;
use zip::ZipArchive;

fn main() {
    println!("Enter the app name:");
    let mut app_name = String::new();
    std::io::stdin().read_line(&mut app_name).expect("Failed to exist");
    let app_name = app_name.trim();


    let db_path = "/sublet/bin3/db.toml";
    let db_contents = std::fs::read_to_string(db_path)
        .expect("Something went wrong reading the db.toml");
    let parsed_toml = db_contents.parse::<Value>().unwrap();


    let app_id = parsed_toml
        .get(app_name)
        .and_then(|v| v.get("id"))
        .and_then(|id| id.as_str())
        .unwrap_or_else(|| panic!("App not found in db.toml"));


    let url = format!("https://raw.githubusercontent.com/Jack-John-Joe/sublet/main/database/{}.zip", app_id);
    let file_path = format!("/sublet/temp/{}.zip", app_id);
    download_file(&url, &file_path);


    let folder_path = "/sublet/temp";
    unzip_file(&file_path, folder_path);


    let script_path = format!("{}/msubl.sh", folder_path);
    let output = Command::new("sh")
        .arg(script_path)
        .output()
        .expect("no");

    println!("{:?}", output.stdout);
}

fn download_file(url: &str, file_path: &str) {
    println!("Downloading file...");
    let mut resp = Client::new()
        .get(url)
        .send()
        .expect("bad internet");

    let mut out = File::create(file_path).expect("uh oh");
    std::io::copy(&mut resp, &mut out).expect("Failed");
}

fn unzip_file(file_path: &str, folder_path: &str) {
    println!("Unzipping file...");
    let file = File::open(file_path).expect("Failed");
    let mut archive = ZipArchive::new(BufReader::new(file)).expect("Failed");

    for i in 0..archive.len() {
        let mut file = archive.by_index(i).expect("Failed");
        let outpath = Path::new(folder_path).join(file.name());

        if (&*file.name()).ends_with('/') {
            std::fs::create_dir_all(&outpath).expect("Failed");
        } else {
            if let Some(p) = outpath.parent() {
                if !p.exists() {
                    std::fs::create_dir_all(&p).expect("Failed");
                }
            }

            let mut outfile = File::create(&outpath).expect("Failed");
            std::io::copy(&mut file, &mut outfile).expect("Failed");
        }
    }
}
