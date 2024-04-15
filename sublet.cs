using System;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Net.Http;
using System.Xml;
using System.Threading.Tasks;

class Sublet
{
    static async Task Main()
    {
        Console.Write("Application name: ");
        string input = Console.ReadLine() ?? string.Empty;  // Handle possible null

        Environment.SetEnvironmentVariable("appn", input, EnvironmentVariableTarget.Process);

        string appn = Environment.GetEnvironmentVariable("appn") ?? string.Empty; // Handle possible null
        Console.WriteLine($"Selected '{appn}'");

        try
        {
            XmlDocument doc = new XmlDocument();
            doc.Load("/sublet/extra/db.xml");  

            XmlNode node = doc.DocumentElement.SelectSingleNode($"/db/app/{appn}/id");

            if (node == null)
            {
                throw new Exception("Application ID not found in XML.");
            }

            string appid = node.InnerText;
            Environment.SetEnvironmentVariable("appid", appid, EnvironmentVariableTarget.Process);

            Console.WriteLine($"Downloading and extracting app package for '{appid}'...");

          
            await DownloadAndExtractZip(appid);

            string shellScriptPath = "/sublet/temp/g/msubl.sh";
            Process.Start(shellScriptPath);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }

        Console.WriteLine("App is installing in a separate window. Press any key to exit.");
        Console.ReadLine();
    }

    static async Task DownloadAndExtractZip(string appid)
    {
        string url = $"https://raw.githubusercontent.com/Jack-John-Joe/sublet/main/database/{appid.ToLower()}.zip";
        string zipPath = $"/sublet/temp/g/{appid}.zip";
        string extractionPath = "/sublet/temp/g/";

        using (HttpClient client = new HttpClient())
        {
            HttpResponseMessage response = await client.GetAsync(url);
            if (response.IsSuccessStatusCode)
            {
                using (FileStream fs = new FileStream(zipPath, FileMode.Create))
                {
                    await response.Content.CopyToAsync(fs);
                }

   
                if (Directory.Exists(extractionPath))
                {
                    Directory.Delete(extractionPath, true);
                }
                Directory.CreateDirectory(extractionPath);

                ZipFile.ExtractToDirectory(zipPath, extractionPath, true);
                Console.WriteLine("Extraction complete.");


                File.Delete(zipPath);
            }
            else
            {
                throw new Exception($"Failed to download the zip file from '{url}'. Status: {response.StatusCode}");
            }
        }
    }
}
