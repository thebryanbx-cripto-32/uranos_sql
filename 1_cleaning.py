import pandas as pd
from ucimlrepo import fetch_ucirepo
from pathlib import Path

CLEANED_PATH = Path("data")

def extract():
    """Fetch dataset directly from ucimlrepo"""
    wine_quality = fetch_ucirepo(id=186)

    X = wine_quality.data.features
    y = wine_quality.data.targets

    df = pd.concat([X, y], axis=1)
    return df

def transform(df):
    """Clean and split dataset into 3 tables"""

    # Clean column names
    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_", regex=False)
    )

    # Remove missing values and duplicates
    df = df.dropna()  
    df = df.drop_duplicates()
    df = df.reset_index(drop=True)

    # Create primary key
    df["wine_id"] = df.index + 1

    # TABLE 1: wines
    wines = df[["wine_id", "alcohol", "density", "ph", "quality"]].copy()
    wines.rename(columns={"ph": "pH"}, inplace=True)

    # TABLE 2: acidity
    acidity = df[["wine_id", "fixed_acidity", "volatile_acidity", "citric_acid"]].copy()
    acidity.insert(0, "acidity_id", range(1, len(acidity) + 1))

    # TABLE 3: composition
    composition = df[["wine_id", "residual_sugar", "chlorides", "sulphates"]].copy()
    composition.insert(0, "comp_id", range(1, len(composition) + 1))

    return wines, acidity, composition

def load(wines, acidity, composition):
    """Save CSV files"""
    CLEANED_PATH.mkdir(parents=True, exist_ok=True)

    wines.to_csv(CLEANED_PATH / "wines.csv", index=False, sep=';')
    acidity.to_csv(CLEANED_PATH / "acidity.csv", index=False, sep=';')
    composition.to_csv(CLEANED_PATH / "composition.csv", index=False, sep=';')

def main():
    df = extract()

    print("Original shape:", df.shape)
    print("Missing values before cleaning:\n", df.isnull().sum())
    print("Duplicates before cleaning:", df.duplicated().sum())

    wines, acidity, composition = transform(df)
    load(wines, acidity, composition)

    print("\nCleaned files created successfully.")
    print("wines shape:", wines.shape)
    print("acidity shape:", acidity.shape)
    print("composition shape:", composition.shape)

if __name__ == "__main__":
    main()