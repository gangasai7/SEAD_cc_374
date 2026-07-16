import { useState } from "react";

function SearchBar({ setData }) {
  const [orcid, setOrcid] = useState("");
  const [author, setAuthor] = useState("");
  const [loading, setLoading] = useState(false);  // ✅ added

  const handleSearch = async () => {
    setLoading(true);  // ✅ start loading

    try {
         const res = await fetch("/api/search", {      
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          orcid: orcid,
          author: author
        })
      });

      const data = await res.json();
      console.log(data);
      setData(data.publications);

    } catch (error) {
      console.error("Error:", error);
    }

    setLoading(false);  // ✅ stop loading
  };

  return (
    <div>
      <input
        onChange={(e) => setOrcid(e.target.value)}
        placeholder="ORCID"
      />
      <input
        onChange={(e) => setAuthor(e.target.value)}
        placeholder="Author"
      />

      {/* ✅ Button with loading text */}
      <button onClick={handleSearch}>
        {loading ? "Loading..." : "Search"}
      </button>
    </div>
  );
}

export default SearchBar;