
# Dictionnaire pour les coûts sur le graphe (pour Dijkstra, A* et glouton )
couts = Dict(
    '@' => 0,
    'W' => 8,
    'S' => 5
)


function lireMapNonPondere(fichier)
    matrice = []
    lecture_active = false    # on commence sans lire la map

    open(fichier, "r") do f # lire le fichier et le refermer
        for ligne in eachline(f)

            # Dès qu'on voit "map", on active la lecture
            if strip(ligne) == "map"
                lecture_active = true
                continue       
            end

            # On ne traite les lignes que si on a vu "map"
            if lecture_active && !isempty(strip(ligne))
                row = [c == '@' ? 0 : 1 for c in strip(ligne)] #pour chaque caractères on met un cout de 0 si c est "@" sinon 1
                push!(matrice, row)
            end
        end
    end

    return reduce(vcat, transpose.(matrice)) # rend le Vector de Vector en Matrice
end



function lireMapPondere(fichier)
    matrice = []
    lecture_active = false    # on commence sans lire la map

    open(fichier, "r") do f # lire le fichier et le refermer 
        for ligne in eachline(f)

            # Dès qu'on voit "map", on active la lecture
            if strip(ligne) == "map"
                lecture_active = true
                continue       
            end

            # On ne traite les lignes que si on a vu "map"
            if lecture_active && !isempty(strip(ligne))
                row = [get(couts, c, 1) for c in strip(ligne)] #pour chaque caractères on regarde si ils ont un coûts sinon on leur met 1 
                push!(matrice, row)
            end
        end
    end

    return reduce(vcat, transpose.(matrice)) # rend le Vector de Vector en Matrice
end

