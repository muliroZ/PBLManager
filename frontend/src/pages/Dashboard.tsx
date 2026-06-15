import { useState, useEffect } from "react";
import { type Equipe } from "../types/equipes";
import { CardEquipe } from "../components/CardEquipe";
import { AbasSprints } from "../components/AbasSprints";

export default function Dashboard() {
    const [equipes, setEquipes] = useState<Equipe[]>([]);
    const [equipeSelecionadaId, setEquipeSelecionadaId] = useState<number | null>(null)
    const [loading, setLoading] = useState<boolean>(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
      fetch('http://localhost:5000/api/equipes')
        .then((res) => {
            if (!res.ok) throw new Error('Erro ao carregar os dados do servidor.');
            return res.json();
        })
        .then((data: Equipe[]) => {
            setEquipes(data);
            setLoading(false);
        })
        .catch((err) => {
            setError(err.message);
            setLoading(false);
        });
    }, []);

    if (loading) return <p>Carregando...</p>;
    if (error) return <p style={{ color: 'red' }}>Ocorreu um erro: {error}</p>;

    return (
        <div style={{ padding: '2rem' }}>
            <h1>PBLManager - Painel Geral</h1>

            {!equipeSelecionadaId ? (
                <div 
                    style={{ 
                        display: 'flex', 
                        gap: '1.5rem', 
                        flexWrap: 'wrap', 
                        marginTop: '2rem', 
                        justifyContent: 'center',
                    }}
                >
                {equipes.length === 0 ? (
                    <p>Nenhuma equipe cadastrada no sistema.</p>
                ) : (
                    equipes.map((equipe) => (    
                        <CardEquipe 
                            key={equipe.codigo_equipe} 
                            equipe={equipe} 
                            onVerSprints={() => setEquipeSelecionadaId(equipe.codigo_equipe)}
                        />
                    ))
                )}
                </div>
            ) : (
                <div>
                    <button onClick={() => setEquipeSelecionadaId(null)}>Voltar para o painel</button>
                    <AbasSprints codigoEquipe={equipeSelecionadaId} />
                </div>
            )}
        </div>
    );
}